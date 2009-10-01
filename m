From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Thu, 1 Oct 2009 11:28:47 +0200
Message-ID: <20091001092847.GG5718__30209.1181664311$1254389623$gmane$org@redhat.com>
References: <4ABA61D1.80703@gmail.com> <4ABA78DC.7070604@redhat.com>
	<4ABA8FDC.5010008@gmail.com> <4ABB1D44.5000007@redhat.com>
	<4ABBB46D.2000102@gmail.com> <4ABC7DCE.2000404@redhat.com>
	<4ABD36E3.9070503@gmail.com> <4ABF33B2.4000805@redhat.com>
	<4AC3B9C6.5090408@gmail.com> <4AC46989.7030502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AC46989.7030502@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 01, 2009 at 10:34:17AM +0200, Avi Kivity wrote:
>> Second, I do not use ioeventfd anymore because it has too many problems
>> with the surrounding technology.  However, that is a topic for a
>> different thread.
>>    
>
> Please post your issues.  I see ioeventfd/irqfd as critical kvm interfaces.

I second that. AFAIK ioeventfd/irqfd got exposed to userspace in 2.6.32-rc1,
if there are issues we better nail them before 2.6.32 is out.
And yes, please start a different thread.

-- 
MST
