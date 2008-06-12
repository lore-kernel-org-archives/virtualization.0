From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Do not calculate linear rip in emulation failure report
Date: Thu, 12 Jun 2008 16:00:09 +0300
Message-ID: <48511DD9.60406__45707.8226995238$1213275875$gmane$org@qumranet.com>
References: <1213105613-8571-1-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1213105613-8571-1-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <gcosta@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Glauber Costa wrote:
> If we're not gonna do anything (case in which failure is already
> reported), we do not need to even bother with calculating the linear rip.
>
> This is a nitpick, but I saw it while doing some testing, so here's
> the patch.
>
>   

Applied, thanks.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
