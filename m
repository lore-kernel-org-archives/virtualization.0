From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv2 virtio-next] remoteproc: Add support for host virtio
	rings (vringh)
Date: Tue, 23 Apr 2013 14:02:03 +0300
Message-ID: <CAK=WgbYYjJz-g+hCWkohgJGnvvtnq0b8RAG-YV3wug4NZ-DWPw@mail.gmail.com>
References: <1365543588-5152-1-git-send-email-sjur.brandeland@stericsson.com>
	<CAK=WgbZoqD5aoLt6nqGW3Y42=e_qK2kH0hf0FTLJr=WGW81Azg@mail.gmail.com>
	<87txmxgb96.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87txmxgb96.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Suman Anna <s-anna@ti.com>, Loic Pallardy <loic.pallardy@stericsson.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur@brendeland.net>, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization <virtualization@lists.linux-foundation.org>, =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 23, 2013 at 6:46 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Oh, we can break everything :)
>
> I was concentrating purely on the mechanics of the virtqueue, mainly
> because vhost has special needs wrt tracking changes.  vhost doesn't use
> vringh yet because my patches are slightly suboptimal (I stick with the
> vhost API, just replace the guts with vringh).  Michael has a
> simplification of vhost-net pending, which will make altering this much
> easier.
>
> But CAIF isn't the right thing to optimize for, either.  It's weird to
> have both host and guest rings at the same time, and I don't see other
> users doing that (ie. vhost_net and tcm_vhost).  But if we can make it
> easier for you without overly uglifying vringh, that'd be great.

Thanks.

Today with one application processor talking to one or several remote
cores we live well with guest rings, but future SoCs seems to be
having an increasing number of on-chip cores which all talk to each
other. Managing this matrix of communications with guest rings is
somewhat cumbersome - it requires deciding, for every two cores, who
is "the guest" and who is "the host". As the number of edges in this
graph increases, this would be increasingly harder to develop, set up
and debug.

In such environments it makes sense to have, for each pair of on-chip
cores, 1 guest and 1 host ring. This way each core will maintain its
own TX buffers and send a buffer across whenever it has a pending
outbound message. This also works well with systems where each core
has its own memory which only it can write to, and from which others
could only read.

So I expect additional users for this paradigm CAIF has adopted -
probably rpmsg at the very least - which makes it even more appealing
to clean up nicely. Last year I discussed this at least with Loic
(STE) and Suman (TI) and both companies were actively developing this
for their future SoCs - I'm cc'ing both in case there are any updates.

Thanks,
Ohad.
