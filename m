From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 10/11] vsock_test: skip read() in test_stream*close
	tests on a VMCI host
Date: Thu, 22 Aug 2019 12:08:35 +0200
Message-ID: <20190822100835.7u27ijlaydk72orv__42455.5797058687$1566468535$gmane$org@steredhat>
References: <20190801152541.245833-1-sgarzare@redhat.com>
	<20190801152541.245833-11-sgarzare@redhat.com>
	<20190820083203.GB9855@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190820083203.GB9855@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>, Jorgen Hansen <jhansen@vmware.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 20, 2019 at 09:32:03AM +0100, Stefan Hajnoczi wrote:
> On Thu, Aug 01, 2019 at 05:25:40PM +0200, Stefano Garzarella wrote:
> > When VMCI transport is used, if the guest closes a connection,
> > all data is gone and EOF is returned, so we should skip the read
> > of data written by the peer before closing the connection.
> 
> All transports should aim for identical semantics.  I think virtio-vsock
> should behave the same as VMCI since userspace applications should be
> transport-independent.

Yes, it is a good point!

> 
> Let's view this as a vsock bug.  Is it feasible to change the VMCI
> behavior so it's more like TCP sockets?  If not, let's change the
> virtio-vsock behavior to be compatible with VMCI.

I'm not sure it is feasible to change the VMCI behavior. IIUC reading the
Jorgen's answer [1], this was a decision made during the implementation.

@Jorgen: please, can you confirm? or not :-)

If it is the case, I'll change virtio-vsock to the same behavior.


Thanks,
Stefano

[1] https://patchwork.ozlabs.org/cover/847998/#1831400
