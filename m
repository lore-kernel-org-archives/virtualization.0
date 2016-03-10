From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio-vsock live migration
Date: Fri, 11 Mar 2016 01:56:05 +0200
Message-ID: <20160311014147-mutt-send-email-mst__2620.76619915224$1457654228$gmane$org@redhat.com>
References: <20160303153737.GA19780@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160303153737.GA19780@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Matt Benjamin <mbenjamin@redhat.com>, virtualization@lists.linux-foundation.org, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 03, 2016 at 03:37:37PM +0000, Stefan Hajnoczi wrote:
> Michael pointed out that the virtio-vsock draft specification does not
> address live migration and in fact currently precludes migration.
> 
> Migration is fundamental so the device specification at least mustn't
> preclude it.  Having brainstormed migration with Matthew Benjamin and
> Michael Tsirkin, I am now summarizing the approach that I want to
> include in the next draft specification.
> 
> Feedback and comments welcome!  In the meantime I will implement this in
> code and update the draft specification.
> 
> 1. Requirements
> 
> Virtio-vsock is a new AF_VSOCK transport.  As such, it should provide at
> least the same guarantees as the existing AF_VSOCK VMCI transport.  This
> is for consistency and to allow code reuse across any AF_VSOCK
> transport.
> 
> Virtio-vsock aims to replace virtio-serial by providing the same
> guest/host communication ability but with sockets API semantics that are
> more popular and convenient for application developers.  Therefore
> virtio-vsock migration should provide at least the same level of
> migration functionality as virtio-serial.
> 
> Ideally it should be possible to migrate applications using AF_VSOCK
> together with the virtual machine so that guest<->host communication is
> interrupted.  Neither AF_VSOCK VMCI nor virtio-serial support this
> today.

I'm not sure why do you say this about virtio serial.
It appears that if host pre-connected to destination
qemu before migration, backend reconnects transparently
on destination.


> 2. Basic disruptive migration flow
> 
> When the virtual machine migrates from the source host to the
> destination host, the guest's CID may change.  The CID namespace is
> host-wide


BTW, I think CIDs would have to become per network namespace.

> so other hosts may have CID collisions and allocate a new CID
> for incoming migration VMs.

I guess all this is so that guest can retrieve its CID and
send it to host using some side-channel?


> The device notifies the guest that the CID has changed.  Guest sockets
> are affected as follows:
> 
>  * Established connections are reset (ECONNRESET) and the guest
>    application will have to reconnect.
> 
>  * Listen sockets remain open.  The only thing to note is that
>    connections from the host are now made to the new CID.  This means
>    the local address of the listen socket is automatically updated to
>    the new CID.
> 
>  * Sockets in other states are unchanged.
> 
> Applications must handle disruptive migration by reconnecting if
> necessary after ECONNRESET.
> 
> 3. Checkpoint/restore for seamless migration
> 
> Applications that wish to communicate across live migration can do so
> but this requires extra application-specific checkpoint/restore code.
> 
> This is similar to the approach taken by the CRIU project where
> getsockopt()/setsockopt() is used to migrate socket state.  The
> difference is that the application process is not automatically migrated
> from the source host to the destination host.  Therefore, the
> application needs to migrate its own state somehow.
> 
> The flow is as follows:
> 
> The application on the source host must quiesce (stop sending/receiving)
> and use getsockopt() to extract socket state information from the host
> kernel.
> 
> A new instance of the application is started on the destination host and
> given the state so it can restore the connection.  The setsockopt()
> syscall is used to restore socket state information.
> 
> The guest is given a list of <host_old_cid, host_new_cid, host_port,
> guest_port> tuples for established connections that must not be reset
> when the guest CID update notification is received.  These connections
> will carry on as if nothing changed.
> 
> Note that the connection's remote address is updated from host_old_cid
> to host_new_cid.  This allows remapping of CIDs (if necessary).
> Typically this will be unused because the host always has well-known CID
> 2.  In a guest<->guest scenario it may be used to remap CIDs.
> 
> 
> For the time being I am focussing on the basic disruptive migration flow
> only.  Checkpoint/restore can be added with a feature bit in the future.
> It is a lot more complex and I'm not sure whether there will be any
> users yet.
> 
> Stefan

This makes some things harder. For example, imagine a guest
reboot mixed with migration. We don't know why did the connection
die, so we'll retry connections until - when?

Could you please describe some user of vsock and show how
it recovers from destructive migration?

-- 
MST
