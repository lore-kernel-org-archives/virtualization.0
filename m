From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [kvm-devel] [PATCH 0/24] paravirt_ops for unified x86 - that's
 me again!
Date: Tue, 13 Nov 2007 12:26:24 -0800
Message-ID: <473A0870.4070104__166.005505207245$1194985913$gmane$org@goop.org>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<200711121347.20050.amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200711121347.20050.amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> Glauber, are you planning on consolidating the dma_ops structure for 32- and 
> 64-bit? 32-bit doesn't currently have a dma_mapping_ops structure, which 
> makes paravirtualizing DMA access difficult on 32-bit.


I think it's a good idea.  While I haven't worked out the details yet,
it seems like something I'll need for Xen dom0 support.

    J
