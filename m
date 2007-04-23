From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Mon, 23 Apr 2007 12:21:19 -0700
Message-ID: <462D072F.6030809@goop.org>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de> <4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com> <4627E099.209@goop.org>	<m1d51vxxm4.fsf@ebiederm.dsl.xmission.com> <462CE027.4030302@goop.org>	<462CE1E0.9060007@zytor.com>	<m1zm4zvwfr.fsf@ebiederm.dsl.xmission.com>	<462CF5B8.4070708@xensource.com> <m1y7kivs3s.fsf@ebiederm.dsl.xmission.com> <462D04B2.6080008@goop.org> <462D05A0.1020100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161469AbXDWTVQ@vger.kernel.org>
In-Reply-To: <462D05A0.1020100@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Chuck Ebbert <cebbert@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> It would be *trivial* to make a certain number of page table slots
> available at the end of the head.S-generated map. 

Or you could use a fixmap.

    J
