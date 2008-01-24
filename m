From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] Make virtio modules GPL
Date: Thu, 24 Jan 2008 12:04:16 +1100
Message-ID: <200801241204.17136.rusty__48675.2053526745$1201136843$gmane$org@rustcorp.com.au>
References: <1199307694277-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1199307694277-git-send-email-aliguori@us.ibm.com>
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
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 03 January 2008 08:01:32 Anthony Liguori wrote:
> The virtio modules do not advertise themselves as GPL but rely on exported
> GPL symbols.  This makes them unloadable as modules.
>
> This patch adds the appropriate MODULE_LICENSE().

Hmm, this is already at the bottom of virtio_blk and virtio_net.  I moved the 
others to the bottom too.

Cheers,
Rusty.
