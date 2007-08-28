From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Tue, 28 Aug 2007 13:18:02 +0200
Message-ID: <1188299882.5972.82.camel@localhost.localdomain>
References: <46CBC842.4070100@vmware.com>  <46CBCADF.2070400@qumranet.com>
	 <1187763956.6174.48.camel@localhost.localdomain>
	 <1188237281.5972.69.camel@localhost.localdomain>
	 <46D3C60B.3050605@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756341AbXH2RIE@vger.kernel.org>
In-Reply-To: <46D3C60B.3050605@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org


> We have an X driver that does minimal performance costing operations.  
> As we should and will have for our other drivers.

Ok, so you use your own DDX and prevent X vgacrapware to kick in ? Makes
sense.

Ben.
