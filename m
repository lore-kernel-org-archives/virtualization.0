From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_net: Fix open <-> interrupt race
Date: Wed, 6 Feb 2008 15:00:03 +1100
Message-ID: <200802061500.04138.rusty__27542.1011065648$1202270538$gmane$org@rustcorp.com.au>
References: <200802051436.10841.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200802051436.10841.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: netdev@vger.kernel.org, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 06 February 2008 00:36:10 Christian Borntraeger wrote:
> I got the following oops during interface ifup. Unfortunately its not
> easily reproducable so I cant say for sure that my fix fixes this
> problem, but I am confident and I think its correct anyway:

Looks fine, and certainly shouldn't hurt.  Please push this out.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks,
Rusty.
