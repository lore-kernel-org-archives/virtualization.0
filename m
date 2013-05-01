From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv2 virtio-next] remoteproc: Add support for host virtio
	rings (vringh)
Date: Wed, 1 May 2013 08:42:07 +0300
Message-ID: <CAK=Wgbb5uv2npwmDaZFoyvMVKv3HAE9L41n8Vy2zqnBVev0-xA@mail.gmail.com>
References: <1365543588-5152-1-git-send-email-sjur.brandeland@stericsson.com>
	<CAK=WgbZoqD5aoLt6nqGW3Y42=e_qK2kH0hf0FTLJr=WGW81Azg@mail.gmail.com>
	<87txmxgb96.fsf@rustcorp.com.au>
	<CAK=WgbYYjJz-g+hCWkohgJGnvvtnq0b8RAG-YV3wug4NZ-DWPw@mail.gmail.com>
	<87ehdudvlr.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ehdudvlr.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur@brendeland.net>, Loic Pallardy <loic.pallardy@stericsson.com>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization <virtualization@lists.linux-foundation.org>, Suman Anna <s-anna@ti.com>, Linus Walleij <linus.walleij@linaro.org>, =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 29, 2013 at 3:33 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Ohad Ben-Cohen <ohad@wizery.com> writes:
>> On Tue, Apr 23, 2013 at 6:46 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>> Oh, we can break everything :)
>>>
>>> I was concentrating purely on the mechanics of the virtqueue, mainly
>>> because vhost has special needs wrt tracking changes.  vhost doesn't use
>>> vringh yet because my patches are slightly suboptimal (I stick with the
>>> vhost API, just replace the guts with vringh).  Michael has a
>>> simplification of vhost-net pending, which will make altering this much
>>> easier.
>>>
>>> But CAIF isn't the right thing to optimize for, either.  It's weird to
>>> have both host and guest rings at the same time, and I don't see other
>>> users doing that (ie. vhost_net and tcm_vhost).  But if we can make it
>>> easier for you without overly uglifying vringh, that'd be great.
>>
>> Thanks.
>>
>> Today with one application processor talking to one or several remote
>> cores we live well with guest rings, but future SoCs seems to be
>> having an increasing number of on-chip cores which all talk to each
>> other. Managing this matrix of communications with guest rings is
>> somewhat cumbersome - it requires deciding, for every two cores, who
>> is "the guest" and who is "the host". As the number of edges in this
>> graph increases, this would be increasingly harder to develop, set up
>> and debug.
>>
>> In such environments it makes sense to have, for each pair of on-chip
>> cores, 1 guest and 1 host ring. This way each core will maintain its
>> own TX buffers and send a buffer across whenever it has a pending
>> outbound message. This also works well with systems where each core
>> has its own memory which only it can write to, and from which others
>> could only read.
>>
>> So I expect additional users for this paradigm CAIF has adopted -
>> probably rpmsg at the very least - which makes it even more appealing
>> to clean up nicely. Last year I discussed this at least with Loic
>> (STE) and Suman (TI) and both companies were actively developing this
>> for their future SoCs - I'm cc'ing both in case there are any updates.
>
> Perhaps we should add a new struct virtio_pair (?), with associated ops,
> which works on top of the existing stuff.  That may be too many levels
> of abstraction, but it feels right.

Interesting idea!

> I don't mind Sjur's current simple code; there's nothing magical about
> upstream APIs, and I'm happy to merge it now and add an abstraction
> later.  It's a pretty common practice, but it's your call.

I agree the code is simple but the problem is that it's basically a
duplication of existing code (see remoteproc_virtio.c) with very
little changes. Since I personally have little time myself to work on
it (unfortunately), I'm concerned that once merged there will be
little incentive for anyone to work on it and eliminate the code
duplication.

Thanks!
Ohad.
