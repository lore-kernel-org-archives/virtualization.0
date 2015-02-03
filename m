From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 0/3] Restore UFO support to virtio_net devices
Date: Mon, 02 Feb 2015 17:49:18 -0800 (PST)
Message-ID: <20150202.174918.1368082761533704490.davem__291.053418959741$1422928169$gmane$org@davemloft.net>
References: <1422889269-16007-1-git-send-email-vyasevic@redhat.com>
	<20150202.131158.2302675247156677150.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150202.131158.2302675247156677150.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: vyasevich@gmail.com
Cc: eric.dumazet@gmail.com, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, hannes@stressinduktion.org, ben@decadent.org.uk
List-Id: virtualization@lists.linuxfoundation.org

From: David Miller <davem@davemloft.net>
Date: Mon, 02 Feb 2015 13:11:58 -0800 (PST)

> Vlad, this still fails the same way.
 ...
> Please build allmodconfig, that is the exact build I use to test your
> and everyone else's changes.

Oh, also, there is trailing whitespace in one of the comments added
by patch #1.  I've been silently fixing it up for you, but since you
have to respin this one more time I'd appreciate it if you're fix
it up in your copy this time. :)

Thanks.
