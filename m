From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCHv4 1/6] qemu/virtio: move features to an inline function
Date: Tue, 03 Nov 2009 07:08:00 +0200
Message-ID: <4AEFBAB0.50202__1977.92615877024$1257225031$gmane$org@redhat.com>
References: <cover.1257200517.git.mst@redhat.com>
	<20091102222329.GB15153@redhat.com> <4AEF5E51.80101@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AEF5E51.80101@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/03/2009 12:33 AM, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> devices should have the final say over which virtio features they
>> support. E.g. indirect entries may or may not make sense in the context
>> of virtio-console. In particular, for vhost, we do not want to report to
>> guest bits not supported by kernel backend.  Move the common bits from
>> virtio-pci to an inline function and let each device call it.
>>
>> No functional changes.
>
> This is a layering violation.  There are transport specific features 
> and device specific features.  The virtio-net device should have no 
> knowledge or nack'ing ability for transport features.

It's equivalent to -cpu host.  Sometimes you want to pass-through host 
capabilities in order to make the best use of your hardware.  In fact, 
even -cpu !host allows the host kernel to nack features since the cost 
of emulation is prohibitive.

> If you need to change transport features, it suggests you're modeling 
> things incorrectly and should be supplying an alternative transport 
> implementation.

Since the kernel and qemu are developed independently, there's no way to 
ensure they support exactly the same capabilities.  The kernel can 
always lag.  The only options are to allow the host kernel to nack 
features, or to fall back to the userspace implementation.

It needs to be finer grained (qemu invoker telling qemu what the minimum 
features are needed, and qemu telling the invoker what capabilties it 
supports) but there's no way around it IMO.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
