From: Ravi Kumar Kulkarni <ravilinux4u@gmail.com>
Subject: unable to write into Local APIC registers
Date: Tue, 21 Dec 2010 18:53:21 +0530
Message-ID: <AANLkTinKvMBrqQn7qZ-m5TW3jnGPsTTRJjh9KdZ7mhGc__341.002157847647$1292937853$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,
Im using qemu 0.12.3 .I have come to a point where i have developed a
small kernel (setting up the IDT, GDT n all)
Im disabling 8259 and enabling Local APIC but im unable to write into
Local APIC registers . can anyone tell me is there something which im
missing
?
Here is my piece of code

SVR                   EQU    0FEE000F0H ; define the Spurious interrupt vector
APIC_ENABLE           EQU    100H
;disable 8259
MOV AL,0FFH
OUT 0A1H, AL
OUT 021H, AL
;enable local apic and set the spurious interrupt vector
MOV ESI,SVR
MOV EAX,<ESI>
OR  EAX,APIC_ENABLE
MOV <ESI>,EAX

Warm regards,
Ravi Kulkarni.
