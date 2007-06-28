From: "Matias Zabaljauregui" <matias.zabaljauregui@cern.ch>
Subject: Lguest
Date: Thu, 28 Jun 2007 19:03:39 +0200
Message-ID: <21a166410706281003p79949542t2f90bfe6e2d7bda3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2115509989373722608=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============2115509989373722608==
Content-Type: multipart/alternative;
	boundary="----=_Part_49122_5755340.1183050219069"

------=_Part_49122_5755340.1183050219069
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Rusty,

I'have just started to read the code (and I'm not an expert kernel
programmer), but is this condition ok ?


(function setup_pagetables(), on file Documentation/lguest.c )

    /* Ideally we map all physical memory starting at page_offset.
     * However, if page_offset is 0xC0000000 we can only map 1G of physical
     * (0xC0000000 + 1G overflows). */

    if (mem > -page_offset)
        mapped_pages = mem/getpagesize();
    else
        mapped_pages = -page_offset/getpagesize();



Cheers

Matias

------=_Part_49122_5755340.1183050219069
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Rusty, <br><br>I&#39;have just started to read the code (and I&#39;m not an expert kernel programmer), but is this condition ok ?<br><br><br>(function setup_pagetables(), on file Documentation/lguest.c )<br><br>&nbsp;&nbsp;&nbsp; /* Ideally we map all physical memory starting at page_offset.
<br>&nbsp;&nbsp;&nbsp; &nbsp;* However, if page_offset is 0xC0000000 we can only map 1G of physical<br>&nbsp;&nbsp;&nbsp; &nbsp;* (0xC0000000 + 1G overflows). */<br><br>&nbsp;&nbsp;&nbsp; if (mem &gt; -page_offset)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mapped_pages = mem/getpagesize();<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mapped_pages = -page_offset/getpagesize();
<br><br><br><br>Cheers<br><br>Matias<br>

------=_Part_49122_5755340.1183050219069--

--===============2115509989373722608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============2115509989373722608==--
