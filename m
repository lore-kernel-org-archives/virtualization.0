From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] tun: Fix/rewrite packet filtering logic
Date: Tue, 22 Jul 2008 17:11:11 -0700 (PDT)
Message-ID: <20080722.171111.267353608.davem__17446.9359605157$1216771987$gmane$org@davemloft.net>
References: <1215852774-23974-1-git-send-email-maxk@qualcomm.com>
	<4886703B.5090609@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4886703B.5090609@garzik.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jeff@garzik.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, maxk@qualcomm.com, linuxkernel@bristyle.com, sjackman@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jeff Garzik <jeff@garzik.org>
Date: Tue, 22 Jul 2008 19:41:47 -0400

> looks mostly OK, but stuff like the above should be
> 
> 	(void __user *) arg
> 
> Did you check this with sparse (Documentation/sparse.txt)?

Jeff, I already added this particular patch to the tree
a week or so ago.
