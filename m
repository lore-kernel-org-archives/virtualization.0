From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 7/8] Add a bootparameter to reserve high
 linear address space.
Date: Tue, 04 May 2010 16:37:38 -0700
Message-ID: <4BE0AFC2.2090207@goop.org>
References: <20060803002510.634721860@xensource.com>
	<20060803002518.595166293@xensource.com>
	<19700101001522.GA3999@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <19700101001522.GA3999@ucw.cz>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 12/31/1969 04:15 PM, Pavel Machek wrote:
> Dynamically loaded hypervisor? Do we really want to support that?
>   

(Missed this because your datestamp was 1969...)

The idea was that you could boot a guest under VMWare fully virtualized
then switch it to a VMI guest by loading a module.  I don't think it
ever worked out - the transition was too trick to get right (especially
applying all the pvops patching to a live system).

    J
