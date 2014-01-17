From: Michael Dalton <mwdalton@google.com>
Subject: Re: [PATCH net-next v4 1/6] net: allow > 0 order atomic page alloc in
	skb_page_frag_refill
Date: Thu, 16 Jan 2014 16:30:11 -0800
Message-ID: <CANJ5vPLZZKqPxZ6yC4sympZODy5h0NjrOTkNS3g+ZG6_9KUi=w__37725.4411382184$1389918646$gmane$org@mail.gmail.com>
References: <1389901950-3854-1-git-send-email-mwdalton@google.com>
	<20140116.152800.901405996505782677.davem@davemloft.net>
	<20140116.153020.587523865163482894.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140116.153020.587523865163482894.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, lf-virt <virtualization@lists.linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ben Hutchings <bhutchings@solarflare.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 16, 2014 at 3:30 PM, David Miller <davem@davemloft.net> wrote:
> Actually, I reverted, please resubmit this series with the following
> build warning corrected:

Thanks David, I will send out another patchset shortly with the warning
resolved and a header e-mail (and one other sysfs group fix that I just
found in the same file). Sorry I didn't include a header e-mail
initially.

Best,

Mike
