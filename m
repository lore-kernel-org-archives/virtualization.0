From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] virtio-pci: switch to modern accessors for 1.0
Date: Thu, 05 Mar 2015 10:43:52 +1030
Message-ID: <87a8zsjo73.fsf__19825.2397975468$1425524318$gmane$org@rustcorp.com.au>
References: <1425296404-12903-1-git-send-email-mst@redhat.com>
	<1425296404-12903-2-git-send-email-mst@redhat.com>
	<87ioehk39j.fsf@rustcorp.com.au>
	<20150304101410.GA26213@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150304101410.GA26213@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Wed, Mar 04, 2015 at 11:06:08AM +1030, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > virtio 1.0 config space is in LE format for all
>> > devices, use modern wrappers when accessed through
>> > the 1.0 BAR.
>> 
>> Hmm, I'm not so sure about these patches.  It's easy to miss the
>> existence of the _modern variants, and they're 90% the same as the
>> legacy variants.
>> 
>> But as long as it's fixed...
>> 
>> Thanks,
>> Rusty.
>> PS.  rng, block, net and 9p virtio 1.0 seem to work OK on BE guests (LE host).
>
> Hmm good point. What if I'll rework this to get bool legacy parameter?

The functions have access to vdev, so they can determine that already.

Simply renaming the old version to _legacy would be enough.

Thanks,
Rusty.
