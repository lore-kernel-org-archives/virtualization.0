From: Wang Chen <wangchen@cn.fujitsu.com>
Subject: Re: [PATCH 3/3] virtio: Use __skb_queue_purge()
Date: Mon, 26 May 2008 16:11:47 +0800
Message-ID: <483A70C3.40507__35498.7046019689$1211899578$gmane$org@cn.fujitsu.com>
References: <200805261742.43215.rusty@rustcorp.com.au>
	<200805261748.13449.rusty@rustcorp.com.au>
	<200805261753.23860.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805261753.23860.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell said the following on 2008-5-26 15:53:
> From: Wang Chen <wangchen@cn.fujitsu.com>
> 
> Use standard routine for queue purging.
> 
> Signed-off-by: Wang Chen <wangchen@cn.fujitsu.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Rusty, Jeff has applied this one and David has merged it and
send a pull request to Linus.
Thanks.
