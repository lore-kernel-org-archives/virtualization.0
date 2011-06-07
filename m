From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 15/49] Staging: hv: vmbus: Make vmbus an acpi bus driver
Date: Tue, 7 Jun 2011 13:44:12 -0700
Message-ID: <20110607204412.GA16429@kroah.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-15-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307400613-13234-15-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 06, 2011 at 03:49:39PM -0700, K. Y. Srinivasan wrote:
> Now, make the vmbus driver an ACPI bus driver.

Why an ACPI bus driver and not a PCI one?  Is that what this really is?
For some reason, I thought it was a PCI device that we hooked our bus
off of, is that not true?

greg k-h
