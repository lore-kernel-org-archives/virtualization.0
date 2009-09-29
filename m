From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 29 Sep 2009 13:40:37 +0200
Message-ID: <200909291340.37431.borntraeger__4425.24092873118$1254224583$gmane$org@de.ibm.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<20090929103354.GA3766@amit-x200.redhat.com>
	<200909291302.51432.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200909291302.51432.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 29 September 2009 13:02:51 schrieb Christian Borntraeger:
> I took a dump and had a look. It looks that this message thing is indeed
>  not the problem. Our early_put_chars method was marked as __init and the
>  old code replaced the put_chars method quickly enough to never make a
>  problem. Removing the __init from early_put_chars solved this kernel bug,
>  but the tty performance is now horribly slow. I will test, if the
>  put_chars method is replaced at all.

I can confirm that your patch changes virtio_console in a way, that the 
early_put_chars function is not replaced by the final one, but I dont see why.

Christian
