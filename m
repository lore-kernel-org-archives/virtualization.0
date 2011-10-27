From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH 1/1] Staging: hv: Move the mouse driver out of staging
Date: Thu, 27 Oct 2011 12:37:14 +0200
Message-ID: <20111027103714.GA13732@aepfle.de>
References: <1319645321-9770-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319645321-9770-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, dmitry.torokhov@gmail.com, jkosina@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 26, K. Y. Srinivasan wrote:

> +static struct  hv_driver mousevsc_drv = {
> +	.name = "mousevsc",

This should be KBUILD_MODNAME.

Olaf
