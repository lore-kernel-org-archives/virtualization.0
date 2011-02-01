From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio: console: Move file back to drivers/char/
Date: Tue, 1 Feb 2011 13:40:55 +0100
Message-ID: <201102011340.56125.arnd__44030.306445393$1296564213$gmane$org@arndb.de>
References: <20110131221454.GA14884@kroah.com>
	<bd7e7969221007e205ef0d2bf144d2f3109036da.1296532834.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <bd7e7969221007e205ef0d2bf144d2f3109036da.1296532834.git.amit.shah@redhat.com>
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
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 01 February 2011, Amit Shah wrote:
> Commit 728674a7e466628df2aeec6d11a2ae1ef968fb67 moved virtio_console.c
> to drivers/tty/hvc/ under the perception of this being an hvc driver.
> It was such once, but these days it has generic communication
> capabilities as well, so move it to drivers/char/.
> 
> In the future, the hvc part from this file can be split off and moved
> under drivers/tty/hvc/.
> 
> CC: Rusty Russell <rusty@rustcorp.com.au>
> CC: Greg KH <greg@kroah.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
