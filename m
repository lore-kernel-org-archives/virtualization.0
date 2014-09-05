From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/3] virtio: simplify virtio_ring.
Date: Fri, 05 Sep 2014 14:27:45 -0700 (PDT)
Message-ID: <20140905.142745.359233584859651695.davem__38435.2923407734$1409952481$gmane$org@davemloft.net>
References: <1409718556-3041-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1409718556-3041-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: netdev@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org, luto@amacapital.net
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Wed,  3 Sep 2014 13:59:13 +0930

> I resurrected these patches after prompting from Andy Lutomirski's
> recent patches.  I put them on the back-burner because vring_bench
> had a 15% slowdown on my laptop: pktgen testing revealed a speedup,
> if anything, so I've cleaned them up.

If you want to merge this via your virtio tree that's fine with me.

For virtio_net:

Acked-by: David S. Miller <davem@davemloft.net>
