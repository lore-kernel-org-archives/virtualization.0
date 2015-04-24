From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Fri, 24 Apr 2015 10:20:28 +0200
Message-ID: <5539FCCC.60708@redhat.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Luke Gorrie <luke@snabb.co>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, virtualization@lists.linux-foundation.org, virtio-comment@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 24/04/2015 10:12, Luke Gorrie wrote:
> 
>     I think this approach could be fruitful in bringing virtio-net to
>     VM-to-VM networking use cases.  Unless virtio-net is extended for this
>     use case, I'm afraid DPDK and OpenDataPlane communities might steer
>     clear of VIRTIO.
> 
> 
> Questions:
> 
> - How fast is needed?
> 
> - How fast is the vhost-user support that shipped in DPDK 2.0?

vhost-user is fast.  The problem is not the speed, it's the desire of a
more peer-to-peer operation.

virtio by design has very distinct roles for driver and device, so for
VM2VM communication the virtio design requires two devices in the guest
and two drivers, comprising a "switch", in the host.

The switch could be using vhost-user indeed, but my understanding is
that in some cases this switch component is undesirable.  However, my
understanding does not include _why_ it is undesirable.  This is where
we need to gather more information from the DPDK folks.

Paolo
