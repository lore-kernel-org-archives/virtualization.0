From: Joe Jin <joe.jin@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen: initialize xen panic handler for PVHVM
Date: Mon, 19 Aug 2013 14:18:42 +0800
Message-ID: <5211B8C2.1010702__47803.8155277774$1376934262$gmane$org@oracle.com>
References: <1376640656-32381-1-git-send-email-vaughan.cao@oracle.com>
	<20130816124327.GC10190@konrad-lan.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130816124327.GC10190@konrad-lan.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Vaughan Cao <vaughan.cao@oracle.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On 08/16/13 20:43, Konrad Rzeszutek Wilk wrote:
> Could you tell me what has been happening without this patch?

Without this patch, Xen would not get pvhvm crash event, any config for
on_crash in guest configure file will not be triggered.

Thanks,
Joe
