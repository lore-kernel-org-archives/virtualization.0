From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 22/59] Staging: hv: vmbus: Get rid of the unused name
 field in struct hv_driver
Date: Thu, 25 Aug 2011 15:35:45 -0700
Message-ID: <20110825223545.GA6055@kroah.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-22-git-send-email-kys@microsoft.com>
 <20110825212428.GA1617@kroah.com>
 <20110825212820.GA6770@kroah.com>
 <6E21E5352C11B742B20C142EB499E048081B360E@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E048081B360E@TK5EX14MBXC126.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 25, 2011 at 10:27:40PM +0000, KY Srinivasan wrote:
> This was existing code and I realized it did not conform to the Linux
> Driver Model. I fixed it in the patch set I had sent earlier (110/117).
> Yesterday I only got up to 74 of the 117 patches that you commented on.
> I was planning to send the rest today. If it is ok with you, please don't fix it here
> As it would break everything else. This is existing code that I am fixing in the patch set
> I will send you shortly.

Oops, as you see, I applied it :)

And I applied the rest of your series, so you might want to re-test and
resync your next series of patches based on what I have in the
staging-next tree now.

thanks,

greg k-h
