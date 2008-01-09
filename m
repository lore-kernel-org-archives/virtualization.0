From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Always notify a virtio_ring when it's full
Date: Wed, 9 Jan 2008 11:34:49 +1100
Message-ID: <200801091134.49479.rusty@rustcorp.com.au>
References: <11998256502093-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11998256502093-git-send-email-aliguori@us.ibm.com>
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
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 09 January 2008 07:54:10 Anthony Liguori wrote:
> I saw that the tx timer was removed in your patch queue but you weren't
> notifying when full.  I decided to do it here instead of in the error case
> on add_buf for really no great reason other than I thought it made more
> sense for it to happen in the notify().

Erk, my bad, I put a ->notify call in the get_buf fail path, not the add_buf 
fail path.

Fixed in latest, thanks.

Rusty.
