From: David Miller <davem@davemloft.net>
Subject: Re: [PATCHv7 1/3] tun: export underlying socket
Date: Wed, 04 Nov 2009 05:30:29 -0800 (PST)
Message-ID: <20091104.053029.166783766.davem__15770.1011318297$1257341502$gmane$org@davemloft.net>
References: <cover.1257267892.git.mst@redhat.com>
	<20091103172400.GB5591@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091103172400.GB5591@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 3 Nov 2009 19:24:00 +0200

> Assuming it's okay with davem, I think it makes sense to merge this
> patch through Rusty's tree because vhost is the first user of the new
> interface.  Posted here for completeness.

I'm fine with that, please add my:

Acked-by: David S. Miller <davem@davemloft.net>
