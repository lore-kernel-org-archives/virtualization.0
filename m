From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 081/117] Staging: hv: vmbus: Introduce a lock to protect
	the ext field in hv_device
Date: Tue, 23 Aug 2011 16:08:16 -0700
Message-ID: <20110823230816.GN9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-81-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-81-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 15, 2011 at 10:47:09AM -0700, K. Y. Srinivasan wrote:
> The current mechanism for handling references in broken.
> Introduce a lock to protect the ext field in hv_device.

Why would that lock ever be needed?  How can things change to this
pointer in different ways like you are thinking it could?  Doesn't the
reference counting in the device itself handle this properly?

greg k-h
