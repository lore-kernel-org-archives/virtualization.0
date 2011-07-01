From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 38/40] Staging: hv: storvsc: Fixup srb_status for INQUIRY
 and MODE_SENSE
Date: Fri, 1 Jul 2011 04:00:47 -0400
Message-ID: <20110701080047.GA28322@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-38-git-send-email-kys@microsoft.com>
 <20110630194754.GG22707@infradead.org>
 <6E21E5352C11B742B20C142EB499E0480816C27C@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0480816C27C@TK5EX14MBXC126.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 30, 2011 at 07:59:28PM +0000, KY Srinivasan wrote:
> The reason I did this was so that  I could key off  on real failures indicated by
> srb_status == 0x4 to off-line the device.

Ok.  Please document what your doing in detail in the code, though.
