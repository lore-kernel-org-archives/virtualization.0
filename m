From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Vmware crashes if compress/misc.c scrolls?
Date: Thu, 21 Jun 2007 20:09:21 -0700
Message-ID: <467B3D61.2010902@goop.org>
References: <4679BBCB.2000202@zytor.com>	<4679C152.8070407@goop.org>	<4679C37E.5020908@zytor.com>	<4679C497.8090500@goop.org>	<4679C595.5010905@zytor.com>	<4679C5DE.7090700@goop.org>	<4679CA51.3080600@zytor.com>
	<467AF39D.5020606@vmware.com>	<467B3276.4060208@zytor.com>
	<467B3525.60500@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <467B3525.60500@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Do you have a sample bootsector that does this?  I would very much 
> like to try booting it rather than writing a mock-up which may or may 
> not exhibit the same behavior.  .iso, floppy images greatly would help.
>
> The very good news is that I should be able to tell you exactly why 
> the exception occurs.  My first thought was perhaps a GDT foul-up 
> resulted in a read-only code segment, and mov %cs:(a000) was faulting 
> or something like that, but this is a total stab in the dark.

The reported bug is that *reads* fail, while writes succeed.  I can't 
think of any way you could manage that easily.

    J
