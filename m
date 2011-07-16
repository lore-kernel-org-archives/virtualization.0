From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 098/117] Staging: hv: storvsc: Handle IDE devices using
 the storvsc driver
Date: Fri, 15 Jul 2011 22:05:20 -0400
Message-ID: <20110716020520.GC7199@infradead.org>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-98-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-98-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 15, 2011 at 10:47:26AM -0700, K. Y. Srinivasan wrote:
> Now, enable handling of all IDE devices by extending the storvsc
> device id table to handle IDE guid. As part of this cleanup Kconfig
> and Hyper-V Makefile to not build the IDE driver (blkvsc).

I think this should be part of the previous patch.
