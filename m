From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] fix drivers/lguest Makefile entry
Date: Wed, 23 Jan 2008 20:42:35 +1100
Message-ID: <200801232042.36173.rusty__39484.2525282458$1201081529$gmane$org@rustcorp.com.au>
References: <12006226032537-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12006226032537-git-send-email-gcosta@redhat.com>
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
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 18 January 2008 13:16:43 Glauber de Oliveira Costa wrote:
> It should depend on CONFIG_LGUEST, not CONFIG_LGUEST_GUEST

Actually, it needs both.  Some parts are guest, some are host.

Cheers,
Rusty.
