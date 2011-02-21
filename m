From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH]: Staging: hv: Allocate the vmbus irq dynamically
Date: Sun, 20 Feb 2011 19:50:30 -0800
Message-ID: <20110221035030.GB29051@kroah.com>
References: <1297799735-25917-1-git-send-email-kys@microsoft.com>
 <alpine.LFD.2.00.1102191046220.2701@localhost6.localdomain6>
 <6E21E5352C11B742B20C142EB499E048011738@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <alpine.LFD.2.00.1102191540290.2701@localhost6.localdomain6>
 <6E21E5352C11B742B20C142EB499E048011787@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <alpine.LFD.2.00.1102201705380.2701@localhost6.localdomain6>
 <6E21E5352C11B742B20C142EB499E04801191C@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E04801191C@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 21, 2011 at 03:43:58AM +0000, KY Srinivasan wrote:
> I am not claiming that what I have done here is the best possible solution.
> However, I will submit to you that it is better than what we had here
> prior to this patch.  I will address this and a  whole lot of other issues 
> in future patches. 

Care to document it in the TODO file so it doesn't get forgotten?

thanks,

greg k-h
