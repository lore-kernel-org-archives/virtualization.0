From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 005/206] Staging: hv: Rename the device type variable
Date: Tue, 10 May 2011 13:43:54 +0100
Message-ID: <4DC9330A.5060106@cam.ac.uk>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com> <1304978288-22999-1-git-send-email-kys@microsoft.com> <1304978288-22999-5-git-send-email-kys@microsoft.com> <4DC90F37.6010000@cam.ac.uk> <20110510121310.GA27396@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110510121310.GA27396@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/10/11 13:13, Greg KH wrote:
> On Tue, May 10, 2011 at 11:11:03AM +0100, Jonathan Cameron wrote:
>> On 05/09/11 22:54, K. Y. Srinivasan wrote:
>>> Rename the variable g_blk_device_type.
>> Why?
> 
> Because "g_blk_device_type" is in Hungarian notation, which isn't needed
> in the kernel.
> 
Fair enough, I'd misunderstood what g_blk referred to. Sorry for the noise.
