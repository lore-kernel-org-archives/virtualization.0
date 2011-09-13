From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 09/20] Staging: hv: storvsc: Get rid of storvsc_dev_add()
 by inlining the code
Date: Tue, 13 Sep 2011 14:39:41 -0400
Message-ID: <20110913183941.GA23318@infradead.org>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-9-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315936796-20662-9-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 13, 2011 at 10:59:45AM -0700, K. Y. Srinivasan wrote:
> Get rid of storvsc_dev_add() by inlining the code.

This also means struct storvsc_device_info can go away, doesn't it?
