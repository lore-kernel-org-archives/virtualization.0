From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 0/6] virtio_balloon: virtio 1 support
Date: Tue, 14 Apr 2015 10:42:56 +0930
Message-ID: <87h9sjtsvb.fsf__6571.73964796147$1428975988$gmane$org@rustcorp.com.au>
References: <1427884468-23930-1-git-send-email-mst@redhat.com>
	<20150412170141-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150412170141-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Wed, Apr 01, 2015 at 02:57:35PM +0200, Michael S. Tsirkin wrote:
>> Virtio 1.0 doesn't include a modern balloon device.  At some point we'll likely
>> define an incompatible interface with a different ID and different
>> semantics.  But for now, it's not a big effort to support a transitional
>> balloon device: this has the advantage of supporting existing drivers,
>> transparently, as well as transports that don't allow mixing virtio 0 and
>> virtio 1 devices. And balloon is an easy device to test, so it's also useful
>> for people to test virtio core handling of transitional devices.
>> 
>> The only interface issue is with the stats buffer, which has misaligned
>> fields. We could leave it as is, but this sets a bad precedent that
>> others might copy by mistake.
>> 
>> As we need to change stats code to do byteswaps for virtio 1.0, it seems easy
>> to fix by prepending a 6 byte reserved field.  I also had to change config
>> structure field types from __le32 to __u32 to match other devices. This means
>> we need a couple of __force tags for legacy path but that seems minor.
>
> Rusty, what are your thoughts here?
> How about merging this for 4.1?

I disagree with making any changes, other than allowing it to be used
with VIRTIO_F_VERSION_1.

However it doesn't seem to bother anyone else, so I've applied it for
4.1.

Thanks,
Rusty.
