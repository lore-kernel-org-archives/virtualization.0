From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 35/40] Staging: hv: storvsc: Make storvsc_dev_add() a
 static function
Date: Thu, 30 Jun 2011 15:45:54 -0400
Message-ID: <20110630194553.GF22707@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-35-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309358377-8537-35-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 29, 2011 at 07:39:32AM -0700, K. Y. Srinivasan wrote:
> Make storvsc_dev_add() a static function.

Making all pending functions static should be fine in a single patch.
