From: "Matias Zabaljauregui" <matias.zabaljauregui@cern.ch>
Subject: lguest over qemu
Date: Wed, 11 Jul 2007 11:51:22 +0200
Message-ID: <21a166410707110251x574bbb13h4c8d70a7e39155c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7840855157722269708=="
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
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

--===============7840855157722269708==
Content-Type: multipart/alternative;
	boundary="----=_Part_1242_22334683.1184147482652"

------=_Part_1242_22334683.1184147482652
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm setting my lguest playing environment with qemu, but didn't have a good
start... maybe because my modest laptop only has 512Mb of RAM.

This is my qemu  command:

                         qemu -s -no-kqemu -m 400 -hda linux26.img  -net
nic,model=rtl8139 -net tap


( linux26.img  includes  a  2.6.21.5 kernel with the lguest-2.6.21-307patch  )


This is my lguest command (executed within the qemu VM):

                          ./lguest 64m /boot/kernel-2.6.21.5 --block=
initrd-1.1-i386.img root=/dev/lbga

always get this message (I have insisted with different virtual ram
amounts):

                    lguest: failed to get page 167304



thank you in advance
Matias Zabaljauregui

------=_Part_1242_22334683.1184147482652
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, <br><br>I&#39;m setting my lguest playing environment with qemu, but didn&#39;t have a good start... maybe because my modest laptop only has 512Mb of RAM.<br><br>This is my qemu&nbsp; command:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu -s -no-kqemu -m 400 -hda 
linux26.img&nbsp; -net nic,model=rtl8139 -net tap<br><br><br>( linux26.img&nbsp; includes&nbsp; a&nbsp; <a href="http://2.6.21.5">2.6.21.5</a> kernel with the lguest-2.6.21-307 patch&nbsp; )<br><br><br>This is my lguest command (executed within the qemu VM): 
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ./lguest 64m /boot/kernel-<a href="http://2.6.21.5">2.6.21.5</a> --block=initrd-1.1-i386.img root=/dev/lbga<br><br>always get this message (I have insisted with different virtual ram amounts): 
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lguest: failed to get page 167304<br><br><br><br>thank you in advance<br>Matias Zabaljauregui<br>

------=_Part_1242_22334683.1184147482652--

--===============7840855157722269708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============7840855157722269708==--
