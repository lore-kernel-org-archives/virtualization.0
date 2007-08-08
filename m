From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 13/25] [PATCH] turn msr.h functions into native versions
Date: Wed, 8 Aug 2007 16:23:53 +0200
Message-ID: <200708081623.53754.ak__24435.716684866$1186583402$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081125.38481.ak@suse.de>
	<5d6222a80708080719k2e2723mdf82572624856246@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708080719k2e2723mdf82572624856246@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

> The instruction is called rdtscp not read_tscp. Please follow that
> 
> Although the operation consists in reading tscp. 

There is no tscp register

-Andi
