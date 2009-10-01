From: Shirley Ma <mashirle@us.ibm.com>
Subject: Re: INFO: task kjournal:337 blocked for more than 120 seconds
Date: Thu, 01 Oct 2009 14:00:20 -0700
Message-ID: <1254430820.5033.4.camel__6567.05286023698$1254430988$gmane$org@localhost.localdomain>
References: <1254345112.8837.9.camel@localhost.localdomain>
	<20091001132012.GA16975@amt.cnet>
	<1254416336.6787.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1254416336.6787.6.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: mcao@us.ibm.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I talked to Mingming, she suggested to use different IO scheduler. The
default scheduler is cfg, after I switch to noop, the problem is gone. 

So there seems a bug in cfg scheduler. It's easily reproduced it when
running the guest kernel, so far I haven't hit this problem on the host
side.

If I need to file a bug for some one to look at, please let me know.

Thanks
Shirley
