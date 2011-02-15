From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3]: Staging: hv: Use native wait primitives
Date: Tue, 15 Feb 2011 10:44:42 -0800
Message-ID: <20110215184441.GA19688@core.coreip.homeip.net>
References: <1297447183-21807-1-git-send-email-kys@microsoft.com>
 <4D5A4565.5030501@gmail.com>
 <FB42D5CCD7B5934EB1827DB5ED9B850E07085CF8@TK5EX14MBXC104.redmond.corp.microsoft.com>
 <20110215140305.GA10301@suse.de>
 <FB42D5CCD7B5934EB1827DB5ED9B850E07085D7F@TK5EX14MBXC104.redmond.corp.microsoft.com>
 <20110215162933.GA30626@suse.de>
 <FB42D5CCD7B5934EB1827DB5ED9B850E07085DE6@TK5EX14MBXC104.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <FB42D5CCD7B5934EB1827DB5ED9B850E07085DE6@TK5EX14MBXC104.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Greg KH <gregkh@suse.de>, Jiri Slaby <jirislaby@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 15, 2011 at 05:52:46PM +0000, KY Srinivasan wrote:
> 
> If I understand you correctly, you would be prefer to have unbounded waiting with comments 
> justifying why we cannot have timeouts. I will roll out a patch once the tree stabilizes.
> 

Just make sure to add a comment explaining why the wait is unbounded.

-- 
Dmitry
