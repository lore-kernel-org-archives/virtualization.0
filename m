From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Use PCI revision field to indicate virtio PCI ABI
	version
Date: Tue, 29 Jan 2008 14:20:59 +1100
Message-ID: <200801291421.00278.rusty@rustcorp.com.au>
References: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
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

On Tuesday 29 January 2008 02:59:59 Anthony Liguori wrote:
> As Avi pointed out, as we continue to massage the virtio PCI ABI, we can
> make things a little more friendly to users by utilizing the PCI revision
> field to indicate which version of the ABI we're using.  This is a hard ABI
> version and incrementing it will cause the guest driver to break.
>
> This is the necessary changes to virtio_pci to support this.
>
> Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

Applied, thanks.

Cheers,
Rusty.
