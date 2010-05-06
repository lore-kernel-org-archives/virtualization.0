From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/3] virtio: console: Handle multiple console port resizes
Date: Thu, 6 May 2010 11:57:17 +0930
Message-ID: <201005061157.17772.rusty@rustcorp.com.au>
References: <1273091709-19963-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1273091709-19963-1-git-send-email-amit.shah@redhat.com>
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
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 6 May 2010 06:05:06 am Amit Shah wrote:
> Hello,
> 
> This series adds resize support for multiple console ports. The size
> for each console is stored in its structure and the host informs the
> guest about size changes via the VIRTIO_CONSOLE_RESIZE control
> message.

Thanks, applied!

Rusty.
