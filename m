From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCHv3 1/3] x86: use ELF format in compressed images.
Date: Sun, 06 Apr 2008 09:38:52 -0700
Message-ID: <47F8FC9C.9090603__25300.2063524493$1207500295$gmane$org@zytor.com>
References: <1202936100-30859-1-git-send-email-ijc@hellion.org.uk>	
	<9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>
	<86802c440804060003q43f14122vd527514daf77cb89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <86802c440804060003q43f14122vd527514daf77cb89@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Ian Campbell <ijc@hellion.org.uk>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Yinghai Lu wrote:
> so will cost every bzImage extra memory copy? that could be 18M or
> even more big.

I wouldn't worry about that.  You will typically have several copies of 
the images during the execution of the boot loader.

	-hpa
