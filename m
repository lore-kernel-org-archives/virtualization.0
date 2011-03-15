From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 05/12] Staging: hv: Get rid of the forward declaration
 for vmbus_uevent
Date: Tue, 15 Mar 2011 15:23:52 -0700
Message-ID: <20110315222352.GA3100@kroah.com>
References: <1300226527-26933-1-git-send-email-kys@microsoft.com>
 <1300226624-27004-1-git-send-email-kys@microsoft.com>
 <1300226624-27004-2-git-send-email-kys@microsoft.com>
 <1300226624-27004-3-git-send-email-kys@microsoft.com>
 <1300226624-27004-4-git-send-email-kys@microsoft.com>
 <1300226624-27004-5-git-send-email-kys@microsoft.com>
 <1300226624-27004-6-git-send-email-kys@microsoft.com>
 <20110315222246.GA2339@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110315222246.GA2339@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 15, 2011 at 03:22:46PM -0700, Greg KH wrote:
> On Tue, Mar 15, 2011 at 03:03:37PM -0700, K. Y. Srinivasan wrote:
> > Get rid of the forward declaration of vmbus_uevent by moving
> > the code around.
> 
> There are 2 05/12 patches and they are different.

Ah, one has the proper subject and changelog entry and the other
doesn't.  Which to use?

thanks,

greg k-h
