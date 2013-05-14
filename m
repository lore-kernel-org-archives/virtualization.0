From: nitesh narayan lal <niteshnarayanlalleo@gmail.com>
Subject: Re: virtio performance analysis
Date: Tue, 14 May 2013 18:04:10 +0530
Message-ID: <CAAtA1-aKK=Cy_gQyv057gtyFoRoKrbHm082Xka4o20PqWZKexA@mail.gmail.com>
References: <CAAtA1-aB_EQruG8ta=xjt8LO-522_5=YbKCL_33exXG2n5vutw@mail.gmail.com>
	<20130506101936.GA16906@redhat.com>
	<CAAtA1-ZTU7oance7f4=eHGqAf-g+u5e+JwPHMp3iAusHgBphLQ@mail.gmail.com>
	<CAAtA1-ZAMfzyuC_XdABXWdEB0-HDqidWEFteWv+s-bm_eDmtQw@mail.gmail.com>
	<CAAtA1-bmzJdmnCBifU+peaxiYTkG9S-Z9CsRdZkFQkHxL=4WGw@mail.gmail.com>
	<20130514075317.GC4368@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130514075317.GC4368@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I was going through the documentation and I had found that avail_event
is used to set the threshold value after which notification will be
sent. If the kick is required or not will be decide on the basis of
the following condition every time:
(u16)(new_idx - avail_event - 1) < (u16)(new_idx - old_idx)
Right now due to avail_event value the kick is been made for every
start_xmit call,
I wanted to know, how could I modify the avail_event value . So that
the kicks are not made for each start_xmit() call.
Regards
Nitesh Narayan Lal


On Tue, May 14, 2013 at 1:23 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, May 14, 2013 at 11:37:35AM +0530, nitesh narayan lal wrote:
>> I was wondering how exactly vq->event is been set and used?
>> Regards
>> Nitesh Narayan Lal
>>
>>
>> On Tue, May 14, 2013 at 11:37 AM, nitesh narayan lal
>> <niteshnarayanlalleo@gmail.com> wrote:
>> > Hi Michael,
>> > I had seen the virtqueue_kick_prepare() where vring_need_event() is
>> > been used, but somehow for every start_xmit() call vq->event and
>> > need_kick is been set to true.
>> > Due to which for every start_xmit() its kicking via notify() routine.
>> > Regards
>> > Nitesh Narayan Lal
>
>
> vq->event if set when guest and host agree to use event index.
> needs_kick comes from comparison of event index (element for
> which host requested an event) and avail index.
>
> We trigger the event when we make available the element
> for which host requested notification.
>
> More detail in the virtio spec.
>
> --
> MST
