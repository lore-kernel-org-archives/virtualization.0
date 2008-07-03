From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] xen: portability clean up and some minor clean up for
	xencomm.c
Date: Thu, 03 Jul 2008 14:53:28 -0700
Message-ID: <486D4A58.60003__43251.3804328211$1215122131$gmane$org@goop.org>
References: <20080703071209.GD15683%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080703071209.GD15683%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Luck,
	Tony" <tony.luck@intel.com>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata wrote:
> clean up of xencomm.c. is_phys_contiguous() is arch dependent
> function that depends on how virtual memory are laid out.
> So split out the function into arch specific code.
>   

I suppose.  But given that ia64 is the only user of xencomm, I'm not too 
concerned about it.  And unless Arm uses it, I suspect it may always be 
the only user...

    J
