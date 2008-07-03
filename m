From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.26-rc8 pv_ops causes Unhandled invalid opcode fault/trap
Date: Thu, 03 Jul 2008 12:39:25 -0700
Message-ID: <486D2AED.4020407__2807.80555117435$1215114104$gmane$org@goop.org>
References: <486CE463.3070002@theshore.net> <486CF3F7.3030309@goop.org>
	<486CF789.7030700@theshore.net> <486D0DA6.7010901@goop.org>
	<486D197A.7040808@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <486D197A.7040808@theshore.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Christopher S. Aker" <caker@theshore.net>
Cc: Xen-devel <xen-devel@lists.xensource.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christopher S. Aker wrote:
> Jeremy Fitzhardinge wrote:
>>>> Were there any other errors/warnings printed here?
>>>
>>> Nope.  Just some whitespace.
>>
>> Are you sure?  Could you send a full xm dmesg log output?  The crash 
>> is from a BUG() caused by a failing hypercall.  Since you have 
>> compiled Xen with debug enabled, it should have printed something 
>> about why it was failing the hypercall.
>
> Unfortunately, I included the entire dmesg output from that xm create 
> run.  Here's more of the transcript in case it's useful:
>
> http://www.theshore.net/~caker/xen/pvops-bug1/log.txt
>
> Although, looking at it again, I did miss this line:
>
> (XEN) mm.c:645:d341 Non-privileged (341) attempt to map I/O space 
> 000d2e50

Good, that's what I was hoping to see.  (Well, actually not that 
*particular* message, which is strange, but some explanatory message at 
least.)

    J
