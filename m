From: "Christopher S. Aker" <caker@theshore.net>
Subject: Re: 2.6.26-rc8 pv_ops causes Unhandled invalid opcode fault/trap
Date: Thu, 03 Jul 2008 16:38:45 -0400
Message-ID: <486D38D5.5000901__45468.1194191382$1215117651$gmane$org@theshore.net>
References: <486CE463.3070002@theshore.net> <486CF3F7.3030309@goop.org>
	<486CF789.7030700@theshore.net> <486D0DA6.7010901@goop.org>
	<486D197A.7040808@theshore.net> <486D2AED.4020407@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <486D2AED.4020407@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>> Although, looking at it again, I did miss this line:
>>
>> (XEN) mm.c:645:d341 Non-privileged (341) attempt to map I/O space 
>> 000d2e50
> 
> Good, that's what I was hoping to see.  (Well, actually not that 
> *particular* message, which is strange, but some explanatory message at 
> least.)

FWIW, I just tried 2.6.26-rc1 and it booted fine.  I can narrow it down 
further if that'd be useful to you.

-Chris
