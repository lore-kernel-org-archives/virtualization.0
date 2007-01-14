From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 02/20] XEN-paravirt: Add a flag to allow the
	VGA console to be disabled
Date: Sun, 14 Jan 2007 00:27:56 +0000
Message-ID: <20070114002756.5ee2b807@localhost.localdomain>
References: <20070113014539.408244126@goop.org>
	<20070113014647.240188180@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070113014647.240188180@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Gerd, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Hoffmann <kraxel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 12 Jan 2007 17:45:41 -0800
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Add a flag to allow the VGA console to be disabled.  The VGA code will
> spin forever if there isn't any real VGA hardware, which will happen
> under Xen.

If it is doing this then the real bug should be fixed so that it doesn't
hang in the same way on a physical system which has no VGA.
