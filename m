From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] virtio-net: invoke zerocopy callback on xmit
	path if no tx napi
Date: Wed, 23 Aug 2017 11:20:45 -0400
Message-ID: <CAF=yD-+U_aWxSmPPY8v8t=JO0MRZ+N+DzVJTAMKYQ5F=pE1PfA__19826.6054889702$1503501723$gmane$org@mail.gmail.com>
References: <20170819063854.27010-1-den@klaipeden.com>
	<5352c98a-fa48-fcf9-c062-9986a317a1b0@redhat.com>
	<CAF=yD-LZ4=WAYfUtY7xRWi50FRSkrcOa+b7uc46xRnC4sbDCzQ@mail.gmail.com>
	<64d451ae-9944-e978-5a05-54bb1a62aaad@redhat.com>
	<20170822204015-mutt-send-email-mst@kernel.org>
	<1503498504.8694.26.camel@klaipeden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1503498504.8694.26.camel@klaipeden.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Koichiro Den <den@klaipeden.com>
Cc: Network Development <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> Please let me make sure if I understand it correctly:
> * always do copy with skb_orphan_frags_rx as Willem mentioned in the earlier
> post, before the xmit_skb as opposed to my original patch, is safe but too
> costly so cannot be adopted.

One more point about msg_zerocopy in the guest. This does add new allocation
limits on optmem and locked pages rlimit.

Hitting these should be extremely rare. The tcp small queues limit normally
throttles well before this.

Virtio-net is an exception because it breaks the tsq signal by calling
skb_orphan before transmission.

As a result hitting these limits is more likely here. But, in this edge case the
sendmsg call will not block, either, but fail with -ENOBUFS. The caller can
send without zerocopy to make forward progress and
trigger free_old_xmit_skbs from start_xmit.

> * as a generic solution, if we were to somehow overcome the safety issue, track
> the delay and do copy if some threshold is reached could be an answer, but it's
> hard for now.> * so things like the current vhost-net implementation of deciding whether or not
> to do zerocopy beforehand referring the zerocopy tx error ratio is a point of
> practical compromise.

The fragility of this mechanism is another argument for switching to tx napi
as default.

Is there any more data about the windows guest issues when completions
are not queued within a reasonable timeframe? What is this timescale and
do we really need to work around this. That is the only thing keeping us from
removing the HoL blocking in vhost-net zerocopy.
