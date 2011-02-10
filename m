From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-net: add schedule check to napi_enable call in
	refill_work
Date: Thu, 10 Feb 2011 12:01:19 +1030
Message-ID: <201102101201.19656.rusty__29859.7913272262$1297301552$gmane$org@rustcorp.com.au>
References: <132885.30568.qm@web110313.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <132885.30568.qm@web110313.mail.gq1.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Bruce Rogers <brogers@novell.com>, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 10 Feb 2011 06:59:25 am Ken Stailey wrote:
> Justification:
> 
> Impact: Under heavy network I/O load virtio-net driver crashes making VM guest unusable.

Hmm, this went badly wrong.  I acked this patch, and it was mailed to
netdev six months ago.

Bruce's patch used spaces instead of tabs, but that should not have caused
it to be dropped.  I've taken that and ported it forwards, will repost now.

Thanks for picking this up off the floor!
Rusty.
