From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] virtio_console: fix uninitialized variable use
Date: Thu, 30 Mar 2017 05:30:42 +0200
Message-ID: <1490844642.4167.28.camel__21143.8652397648$1493076873$gmane$org@gmx.de>
References: <1490819164-7648-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1490819164-7648-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2017-03-29 at 23:27 +0300, Michael S. Tsirkin wrote:

> Hi Mike
> 	if you like, pls send me your Signed-off-by and I'll
> 	change the patch to make you an author.

Nah, it's perfect as it is.  While I was pretty darn sure it was
generic, I intentionally posted it as diagnostic info.

> 	More importantly, pls let me know whether this helps
> 	resolve the issues about hybernation for you!

Well, it prevents kaboom with VIRTIO_CONSOLE_F_MULTIPORT turned off,
but no, it does nada wrt the warnings.

	-Mike
