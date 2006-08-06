From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address space.
Date: Sun, 6 Aug 2006 22:02:23 +0000 (UTC)
Message-ID: <19700101001522.GA3999__4258.86630914665$1154901743$gmane$org__30481.1276889936$1154901743$gmane$org@ucw.cz>
References: <20060803002510.634721860@xensource.com> <20060803002518.595166293@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750740AbWHFWAx@vger.kernel.org>
Date: Thu, 1 Jan 1970 00:15:22 +0000
Content-Disposition: inline
In-Reply-To: <20060803002518.595166293@xensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi!

> Add a bootparameter to reserve high linear address space for hypervisors.
> This is necessary to allow dynamically loaded hypervisor modules, which

Dynamically loaded hypervisor? Do we really want to support that?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
