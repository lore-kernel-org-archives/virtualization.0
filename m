From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH 1/1] hv: Use only one txf buffer per channel and
	kmalloc on initialize
Date: Tue, 14 Dec 2010 01:03:33 +0300
Message-ID: <20101213220333.GA1636@ioremap.net>
References: <1292274861-29673-1-git-send-email-hjanssen@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1292274861-29673-1-git-send-email-hjanssen@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Jesper Juhl <jj@chaosbits.net>, devel@linuxdriverproject.org, Ky Srinivasan <ksrinivasan@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 13, 2010 at 01:14:21PM -0800, Hank Janssen (hjanssen@microsoft.com) wrote:
> +static u8 *shut_txf_buf;
> +static u8 *time_txf_buf;
> +static u8 *hbeat_txf_buf;

Those are accessed without any kind of synchronization. I do not know
exact context, but are you sure it is single-threaded?

-- 
	Evgeniy Polyakov
