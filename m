From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: using cache for virtio allocations?
Date: Thu, 3 May 2012 10:48:53 +0200
Message-ID: <CA+1xoqdRjPCpfhYhe0=m-6SktZ4q8Z01vxE7gG5+PpGQw29crA@mail.gmail.com>
References: <20120503052943.GF8266@redhat.com>
	<CA+1xoqeWJ_nhoZQ+wRdZnB=b=mDFauWJgcjQ3-+ZorJt=bdoAQ@mail.gmail.com>
	<20120503073244.GI8266@redhat.com>
	<CA+1xoqd5dnh6XKdwXd--7wvn_5+RUVBgUaRdwJXbpwXpd1ccaw@mail.gmail.com>
	<20120503084431.GN8266@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120503084431.GN8266@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 3, 2012 at 10:44 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, May 03, 2012 at 10:38:56AM +0200, Sasha Levin wrote:
>> On Thu, May 3, 2012 at 9:32 AM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>> > On Thu, May 03, 2012 at 07:51:18AM +0200, Sasha Levin wrote:
>> >> On Thu, May 3, 2012 at 7:29 AM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
>> >> > Sasha, didn't you have a patch to allocate
>> >> > things using cache in virtio core?
>> >> > What happened to it?
>> >> >
>> >> > Thanks,
>> >> > MST
>> >>
>> >> It got stuck due to several things, and I got sidetracked, sorry. Here
>> >> are the outstanding issues:
>> >>
>> >> 1. Since now we can allocate a descriptor either using kmalloc or from
>> >> the cache, we need a new flag in vring_desc to know how to free it, it
>> >> seems a bit too intrusive,
>> >> and I couldn't thing of a better
>> >> alternative.
>> >
>> > Since that is guest visible it does not sound great, I agree.
>> >
>> > Three ideas:
>> > 1. The logic looks at descriptor size so can we just read
>> > =A0 desc.len before free and rerun the same math?
>>
>> It'll break every time the value is changed (either by the user or by
>> some dynamic algorithm thingie).
>
> Yes but did you intend to implement such complex logic?
> If not let's not over-engineer.

I did intend to allow him to change the value while the device is
running, if we don't want to allow that then it's easy.

>> > 2. For -net the requests are up to max_skb_frags + 2 in size, right?
>> > =A0 Does it make sense to just use cache for net, always?
>> > =A0 That would mean a per device flag.
>>
>> Yup, it could work.
>>
>> > 3. Allocate a bit more and stick extra data before the 1st descriptor.
>>
>> I guess it'll work, but it just seems a bit ugly :)
>
> An understatement.
>
>> >> 2. Rusty has pointed out that no one is going to modify the default
>> >> value we set, and we don't really have a good default value to put
>> >> there (at least, we haven't agreed on a specific value). Also, you
>> >> have noted that it should be a per-device value, which complicates
>> >> this question further since we probably want a different value for
>> >> each device type.
>> >>
>> >> While the first one can be solved easily with a blessing from the
>> >> maintainers, the second one will require testing on various platforms,
>> >> configurations and devices to select either the best "magic" value, or
>> >> the best algorithm to play with threshold.
>> >
>> > Not sure about platforms but for devices that's right.
>> > But this really only means we only change what we tested.
>> > eg see what is good for net and change net in a way
>> > that others will keep using old code.
>>
>> It'll work only if there will be someone following up and actually
>> testing it, since regular users won't be testing it at all (with it
>> being defaulted to off and everything).
>
> Not sure I understand. Whatever patch gets applied will be
> tested beforehand.

I thought you meant that we apply the patch with threshold set at
0/disabled, and based on future tests we will enable it for specific
devices and set best values for threshold, no?
